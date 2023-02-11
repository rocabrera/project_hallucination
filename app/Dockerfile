FROM python:3.9.9

WORKDIR /app

COPY . /app

RUN pip install -U pip \
    && pip install -r requirements.txt

CMD ["python3", "main.py"]