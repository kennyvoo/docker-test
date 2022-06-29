# Docker practice 

Repo : [github-test](https://github.com/kennyvoo/github-test)


### Part 1: Setup 
I'll choose python:3.8-slim


**docker file**
```docker
FROM python:3.8-slim

```



### Part 2: Use docker-compose
``` bash
sudo docker compose -f docker-compose.yaml build
sudo docker compose run -it github-test sh
```


**docker compose file**
```yaml
version: '3'

services:
  github-test:
    container_name: github-test
    image: github-test:v1
    build: 
      context: github-test
      dockerfile: Dockerfile
```


### Part 3: Develop a Python program

Running gui from docker
``` bash
#not sure if this is a good practice
xhost +
docker run -it -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix github-test:v1 sh
apt update
apt-get install x11-xserver-utils -y
apt-get install python-tk -y
pip install matplotlib
python generate_random_numbers.py
exit
#remember to enable it 
xhost -
```

**docker file**
```docker
FROM python:3.8-slim

COPY . .   
```

**generate_random_numbers.py**
```python
import random
import matplotlib
matplotlib.use( 'tkagg' )
import matplotlib.pyplot as plt

rand_nums= [random.randint(1,10) for i in range(10)]
plt.plot(rand_nums)
plt.show()

```

### Part 4: Build a docker image using Dockerfile

``` bash
#not sure if this is a good practice
xhost +
docker run -it -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix github-test:v1 sh
python generate_random_numbers.py
exit
#remember to enable it 
xhost -
```




**docker file**
```docker
FROM python:3.8-slim

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London
RUN apt update \
    && apt install python3-tk -y \
    && apt install x11-xserver-utils -y \
    && pip install matplotlib==3.2.1


COPY . .   

```
### Part 5: Build a "runnable" Dockerfile
Set the environment variable and volume in compose file.
run the script when running the docker

```bash
#not sure if this is a good practice
xhost +
docker compose -f docker-compose.yaml up --build
xhost -

```

**docker file**
```docker
FROM python:3.8-slim

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London
RUN apt update \
    && apt install python3-tk -y \
    && apt install x11-xserver-utils -y \
    && pip install matplotlib==3.2.1


COPY . .   
CMD ["python","generate_random_numbers.py"]
```



**docker compose file**
```yaml
version: '3'

services:
  github-test:
    container_name: github-test-container
    image: github-test:v1
    build: 
      context: ./github-test
      dockerfile: Dockerfile
    volumes:
     - /tmp/.X11-unix:/tmp/.X11-unix
    environment:
     - DISPLAY=unix$DISPLAY
```