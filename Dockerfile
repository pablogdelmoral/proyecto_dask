FROM python:3.9-slim


WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN mkdir notebooks


COPY ./notebooks/ ./notebooks/


# Puerto de jupyter
EXPOSE 8888 8787 8880 8881 8882 8883 8889

# Configurar Jupyter Lab para aceptar conexiones desde cualquier IP
RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.ip = '0.0.0.0'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.allow_root = True" >> /root/.jupyter/jupyter_notebook_config.py

RUN mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension && \
    echo '{"theme": "JupyterLab Dark"}' > /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings

RUN apt-get update && apt-get install -y graphviz

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
