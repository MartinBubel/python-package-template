FROM python:{{ cookiecutter.python_version }}-slim
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# 1. Install necessary packages: locales for language support and git
RUN apt-get update && apt-get install -y locales git && rm -rf /var/lib/apt/lists/*

# 2. Uncomment the en_US.UTF-8 locale in the locales configuration file
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen

# 3. Generate the locale
RUN locale-gen en_US.UTF-8

# 4. Set the default locale environment variables for the container
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

WORKDIR /workspace

CMD ["bash"]
