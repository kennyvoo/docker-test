FROM python:latest

# RUN pip install matplotlib


WORKDIR /usr/local/bin

COPY . .   
# CMD [ "python", "generate_random_numbers.py"]