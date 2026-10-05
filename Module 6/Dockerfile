# 1. Start from an official, lightweight Linux base image with Python pre-installed
FROM python:3.11-slim

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Copy the dependencies list and install them
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copy the application code into the container
COPY app.py .

# 5. Document the port the container intends to use
EXPOSE 5000

# 6. The command to run when the container starts
CMD ["python", "app.py"]