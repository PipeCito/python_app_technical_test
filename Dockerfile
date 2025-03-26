FROM python:3.10-slim AS builder
WORKDIR /
COPY requirements.txt .
COPY app.py .
RUN pip install --no-cache-dir --target=/libs -r requirements.txt
FROM gcr.io/distroless/python3:nonroot
WORKDIR /
COPY --from=builder /libs /libs
COPY --from=builder /app.py /app.py
ENV PYTHONPATH="/libs"
EXPOSE 5000
ENTRYPOINT ["python3", "/app.py"]