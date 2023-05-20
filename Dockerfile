FROM python:3.9

WORKDIR /app

COPY datuak.py .

COPY wisdmDB ./wisdmDB

# Copy the requirements file to the working directory
COPY requirements.txt .

# Install the required libraries
RUN pip install -r requirements.txt

RUN pwd

# Set the entrypoint command to execute the Python script
CMD ["python", "datuak.py"]
