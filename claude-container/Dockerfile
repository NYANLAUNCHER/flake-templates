FROM node:22-bookworm-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        curl \
        ca-certificates \
        bash \
        procps \
        ripgrep \
        less \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Host user and group IDs
ARG USER_ID=1000
ARG GROUP_ID=1000

# Rename existing node user and group
# Prepare home directory, workspace, and Nix store
RUN groupmod -n nixos node && \
    groupmod --gid ${GROUP_ID} nixos && \
    usermod -l nixos -u ${USER_ID} -d /home/nixos node && \
    usermod -g nixos nixos && \
    mkdir -p /home/nixos/src /nix && \
    chown -R nixos:nixos /home/nixos /nix

# Configure environment
ENV HOME=/home/nixos
ENV XDG_CONFIG_HOME=/home/nixos/.config
ENV NIX_CONFIG="experimental-features = nix-command flakes"
ENV PATH="/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/home/nixos/.nix-profile/bin:/home/nixos/.nix-profile/sbin:${PATH}"

# Switch to non-root user
USER nixos

WORKDIR /home/nixos/src

# Install Nix without a daemon
RUN curl -L https://nixos.org/nix/install -o /tmp/nix-install.sh && \
    sh /tmp/nix-install.sh --no-daemon

RUN mkdir -p ~/.config/nix && \
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Start Claude Code
CMD ["claude"]
