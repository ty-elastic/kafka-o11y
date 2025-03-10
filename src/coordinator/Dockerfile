FROM python:3.12.6-slim-bookworm
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /python-docker

COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY *.py ./

ENV PYTHONUNBUFFERED=1

EXPOSE 7010
CMD [ "flask", "run", "--host=0.0.0.0", "-p", "7010" ]
