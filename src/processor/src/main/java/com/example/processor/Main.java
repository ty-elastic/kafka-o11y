package com.example.processor;

import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import io.opentelemetry.api.GlobalOpenTelemetry;
import io.opentelemetry.api.OpenTelemetry;
import io.opentelemetry.api.trace.Tracer;
import io.opentelemetry.api.trace.Span;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.UUID;

@SpringBootApplication
public class Main  implements ApplicationRunner {
    private static final Logger log = LoggerFactory.getLogger(Main.class);

	public static void main(String[] args) {
		SpringApplication.run(Main.class, args);
	}

    @Override
    public void run(ApplicationArguments args) throws Exception {
		// get a reference to the current thread
        final Thread mainThread = Thread.currentThread();

        for (String opt : args.getOptionNames()) {
            log.info(opt + ":" + args.getOptionValues(opt));
        }
        
        String bootstrapServer = args.getOptionValues("bootstrap_server").get(0);

        Producer producer = null;
        if (args.containsOption("out_topic") && args.getOptionValues("out_topic").get(0).equals("") == false) {
            String outTopic = args.getOptionValues("out_topic").get(0);
            producer = new Producer(bootstrapServer, outTopic);
        }

        if (args.containsOption("in_topic") && args.getOptionValues("in_topic").get(0).equals("") == false) {
            String inTopic = args.getOptionValues("in_topic").get(0);
            String inGroup = args.getOptionValues("in_group").get(0);
            final Consumer consumer = new Consumer(bootstrapServer, inTopic, inGroup);

            Runtime.getRuntime().addShutdownHook(new Thread() {
                public void run() {
                    log.info("Detected a shutdown, let's exit by calling consumer.wakeup()...");
                    consumer.wakeup();
    
                    // join the main thread to allow the execution of the code in the main thread
                    try {
                        mainThread.join();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            });

            consumer.run(producer);
        }
        else if (producer != null) {
            Tracer tracer = GlobalOpenTelemetry.getTracer("producer");
            while (true) {
                Span span = tracer.spanBuilder("produceSyntheticMessage").startSpan();
                UUID uuid = UUID.randomUUID();
                producer.notify(uuid.toString());
                span.end();
                Thread.sleep(1000);
            }
        }
    }

	public Main() {

	}

}