FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install nginx -y
RUN apt-get clean

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
