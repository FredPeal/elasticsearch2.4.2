FROM centos:latest

ENV HOME /root
WORKDIR /root

RUN useradd elasticsearch -c 'Elasticsearch User' -d /home/elasticsearch

RUN yum update -y && \
    yum install -y wget && \
    yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
    yum clean all; \
    mkdir /usr/share/elasticsearch/; \
    chmod o-rwx /usr/share/elasticsearch/; \
    curl -L -O https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.4.2/elasticsearch-2.4.2.tar.gz; \
    tar -xvf elasticsearch-2.4.2.tar.gz -C /usr/share/elasticsearch/; \
    mv -v  /usr/share/elasticsearch/elasticsearch-2.4.2/* /usr/share/elasticsearch/; \
    rm -rf  elasticsearch-2.4.2; \
    cd /usr/share/elasticsearch/bin/; \
    chmod -R 777 /usr/share/elasticsearch/bin/; \
    ./plugin install https://github.com/NLPchina/elasticsearch-sql/releases/download/2.4.2.1/elasticsearch-sql-2.4.2.1.zip

COPY elasticsearch.yml /usr/share/elasticsearch/config/
WORKDIR /usr/share/elasticsearch/bin
EXPOSE 9200:9200
CMD [ "./elasticsearch","-Des.insecure.allow.root=true","-FOREGROUN"]

