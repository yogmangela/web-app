FROM 100682590469.dkr.ecr.eu-west-2.amazonaws.com/contino-bakery:contino-bakery-python3.10-0.1.0

WORKDIR /app

COPY app.py requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]
