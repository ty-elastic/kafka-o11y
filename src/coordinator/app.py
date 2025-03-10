from flask import Flask, request, abort
import logging

app = Flask(__name__)
app.logger.setLevel(logging.INFO)

latency = {}

@app.route('/health')
def health():
    return f"KERNEL OK"

@app.post('/latency/<processor>/<value>')
def set_latency_processor(processor, value):
    global latency
    latency[processor] = int(value)
    return {'latency': latency[processor]}

@app.get('/latency/<processor>')
def get_latency_processor(processor):
    global latency
    if processor in latency:
        return {'latency': latency[processor]}
    else:
        return {'latency': 0}
