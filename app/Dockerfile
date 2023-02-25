FROM amazonlinux:latest


RUN yum install python37 -y

WORKDIR /app

COPY . /app

RUN pip3 install -r requirements.txt

# https://sarus.readthedocs.io/en/stable/user/custom-cuda-images.html#controlling-the-nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.0"

CMD ["python3", "src/main.py"]