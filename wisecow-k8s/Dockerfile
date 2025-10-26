FROM ubuntu:22.04

# Update and install dependencies
RUN apt-get update && \
    apt-get install -y fortune-mod cowsay netcat-openbsd dos2unix && \
    apt-get clean && \
    ln -s /usr/games/fortune /usr/bin/fortune && \
    ln -s /usr/games/cowsay /usr/bin/cowsay

# Working directory
WORKDIR /opt/wisecow

# Copy app
COPY wisecow.sh .

# Fix line endings and permissions
RUN dos2unix wisecow.sh && chmod +x wisecow.sh

# Expose port
EXPOSE 4499

# Run app
CMD ["bash", "wisecow.sh"]
