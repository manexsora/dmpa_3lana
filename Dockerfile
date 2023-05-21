FROM python:3.9

WORKDIR /app

COPY datuak.py .

COPY wisdmDB ./wisdmDB

COPY requirements.txt .

RUN pip install -r requirements.txt


# Set the entrypoint command to execute the Python script
CMD ["python", "datuak.py"]
