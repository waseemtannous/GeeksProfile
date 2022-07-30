FROM python

RUN apt-get update && apt-get install -y python3-pip && apt install git && \
    apt-get install default-libmysqlclient-dev libssl-dev -y 

RUN mkdir /GeeksProfile

# apt install libpython3.10 -y && 
WORKDIR /GeeksProfile

COPY . .

RUN pip3 install -r requirements.txt

EXPOSE 8080

CMD [ "python3", "app.py" ]