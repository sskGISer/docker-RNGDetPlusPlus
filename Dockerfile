# 从 PyTorch 的官方镜像开始
FROM pytorch/pytorch:1.8.0-cuda11.1-cudnn8-devel

# 设置工作目录
WORKDIR /tonyxu

# 移除 CUDA 和 NVIDIA ML 的源列表
RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list

# 删除 NVIDIA 的公钥
RUN apt-key del 7fa2af80

# 更新 apt 包管理器
RUN apt-get update

# 安装 wget 工具
RUN apt-get install -y --no-install-recommends wget

# 下载 CUDA 的 keyring 包
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-keyring_1.0-1_all.deb

# 安装下载的 keyring 包
RUN dpkg -i cuda-keyring_1.0-1_all.deb

# 复制 requirements.txt 文件到容器
COPY requirement.txt requirement.txt

# 根据 requirements.txt 文件安装 Python 依赖包
RUN pip install -r requirement.txt

# 更新 apt 包管理器
RUN apt-get update

# 安装额外的系统库
RUN apt-get install -y libglib2.0-0 libsm6 libxext6 libxrender1 libgl1-mesa-glx zip git

# 安装 JDK 8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# 安装 Java 证书
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# 设置 JAVA_HOME 环境变量
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

# 安装 Go 语言
RUN apt-get update && apt-get install -y golang
