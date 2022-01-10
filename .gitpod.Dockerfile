FROM gitpod/workspace-full:latest

USER gitpod

RUN git config --global pull.ff only

ENV GHCUP_INSTALL_BASE_PREFIX=/workspace
ENV CABAL_DIR=/workspace/.cabal

RUN sudo mkdir -p /workspace/.ghcup/bin || true
RUN sudo chown gitpod -cR /workspace/.ghcup
RUN sudo mkdir -p $CABAL_DIR || true
RUN sudo chown gitpod -cR $CABAL_DIR

ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1
RUN curl -sSL https://downloads.haskell.org/~ghcup/x86_64-linux-ghcup -o /workspace/.ghcup/bin/ghcup
RUN chmod a+x /workspace/.ghcup/bin/ghcup

# Add ghcup to PATH
ENV PATH="/workspace/.local/bin:/workspace/.cabal/bin:/workspace/.ghcup/bin:${PATH}"

# Install cabal
RUN ghcup upgrade
RUN ghcup install cabal 3.6.2.0
RUN ghcup set cabal 3.6.2.0

# Install GHC
RUN ghcup install ghc 8.10.7
RUN ghcup set ghc 8.10.7

# Update cabal
RUN cabal update