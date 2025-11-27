FROM python:3.12-slim

WORKDIR /app

# Copy project files
COPY pyproject.toml ./
COPY src/ ./src/

# Install uv for faster dependency installation
RUN pip install --no-cache-dir uv

# Install dependencies using uv
RUN uv pip install --system --no-cache -e .

# Expose port for HTTP transport
EXPOSE 8000

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV LOG_LEVEL=INFO
ENV MCP_TRANSPORT=sse
ENV HOST=0.0.0.0
ENV PORT=8000

# Run the server with SSE transport using FastMCP
CMD ["python", "src/server.py"]
