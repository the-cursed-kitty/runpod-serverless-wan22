FROM runpod/worker-comfyui:5.8.5-base

WORKDIR /comfyui

# System dependencies (needed for MMAudio, VideoHelperSuite, etc.)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsndfile1 \
    espeak-ng \
    && rm -rf /var/lib/apt/lists/*

# Clone every custom node you actually use (one by one = much more reliable)
RUN git clone --depth 1 https://github.com/city96/ComfyUI-GGUF.git custom_nodes/ComfyUI-GGUF
RUN git clone --depth 1 https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git custom_nodes/ComfyUI-Custom-Scripts
RUN git clone --depth 1 https://github.com/rgthree/rgthree-comfy.git custom_nodes/rgthree-comfy
RUN git clone --depth 1 https://github.com/kijai/ComfyUI-KJNodes.git custom_nodes/ComfyUI-KJNodes
RUN git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git custom_nodes/ComfyUI-VideoHelperSuite
RUN git clone --depth 1 https://github.com/chrisgoringe/cg-use-everywhere.git custom_nodes/cg-use-everywhere
RUN git clone --depth 1 https://github.com/Smirnov75/ComfyUI-mxToolkit.git custom_nodes/ComfyUI-mxToolkit
RUN git clone --depth 1 https://github.com/jamesWalker55/comfyui-various.git custom_nodes/comfyui-various
RUN git clone --depth 1 https://github.com/bash-j/mikey_nodes.git custom_nodes/mikey_nodes
RUN git clone --depth 1 https://github.com/DoctorDiffusion/ComfyUI-MediaMixer.git custom_nodes/ComfyUI-MediaMixer
RUN git clone --depth 1 https://github.com/kijai/ComfyUI-MMAudio.git custom_nodes/ComfyUI-MMAudio
RUN git clone --depth 1 https://github.com/princepainter/ComfyUI-PainterI2Vadvanced.git custom_nodes/ComfyUI-PainterI2Vadvanced
RUN git clone --depth 1 https://github.com/GACLove/ComfyUI-VFI.git custom_nodes/ComfyUI-VFI

# Install requirements for each node (safe with || true)
RUN cd custom_nodes/ComfyUI-MMAudio && pip install -r requirements.txt || true && \
    cd ../ComfyUI-WanVideoWrapper && pip install -r requirements.txt || true && \
    cd ../ComfyUI-GGUF && pip install -r requirements.txt || true && \
    cd ../ComfyUI-KJNodes && pip install -r requirements.txt || true && \
    cd ../ComfyUI-VideoHelperSuite && pip install -r requirements.txt || true && \
    cd ../rgthree-comfy && pip install -r requirements.txt || true && \
    cd ../ComfyUI-mxToolkit && pip install -r requirements.txt || true && \
    cd ../comfyui-various && pip install -r requirements.txt || true && \
    cd ../mikey_nodes && pip install -r requirements.txt || true && \
    cd ../ComfyUI-MediaMixer && pip install -r requirements.txt || true && \
    cd ../ComfyUI-PainterI2Vadvanced && pip install -r requirements.txt || true && \
    cd ../ComfyUI-VFI && pip install -r requirements.txt || true && \
    cd ../ComfyUI-Custom-Scripts && pip install -r requirements.txt || true

# Create folders where your models live on the Network Volume
RUN mkdir -p models/diffusion_models models/loras models/mmaudio models/upscale_models models/vae

RUN pip cache purge
