FROM amazonlinux:latest


RUN yum install python37 -y

WORKDIR /app

COPY . /app

RUN pip3 install -r requirements.txt

CMD ["python3", "src/main.py"]