FROM runpod/worker-comfyui:5.8.5-base

WORKDIR /comfyui

# System dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsndfile1 \
    espeak-ng \
    && rm -rf /var/lib/apt/lists/*

# Clone each node separately (more reliable)
RUN git clone --depth 1 https://github.com/kijai/ComfyUI-MMAudio.git custom_nodes/ComfyUI-MMAudio
RUN git clone --depth 1 https://github.com/kijai/ComfyUI-WanVideoWrapper.git custom_nodes/ComfyUI-WanVideoWrapper
RUN git clone --depth 1 https://github.com/city96/ComfyUI-GGUF.git custom_nodes/ComfyUI-GGUF
RUN git clone --depth 1 https://github.com/chrisgoringe/cg-use-everywhere.git custom_nodes/cg-use-everywhere
RUN git clone --depth 1 https://github.com/mikemikemikemike/mikey_nodes.git custom_nodes/mikey_nodes
RUN git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git custom_nodes/ComfyUI-VideoHelperSuite
RUN git clone --depth 1 https://github.com/rgthree/rgthree-comfy.git custom_nodes/rgthree-comfy
RUN git clone --depth 1 https://github.com/Smirnov75/ComfyUI-mxToolkit.git custom_nodes/ComfyUI-mxToolkit
RUN git clone --depth 1 https://github.com/princepainter/ComfyUI-PainterI2Vadvanced.git custom_nodes/ComfyUI-PainterI2Vadvanced
RUN git clone --depth 1 https://github.com/jamesWalker55/comfyui-various.git custom_nodes/comfyui-various
RUN git clone --depth 1 https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git custom_nodes/ComfyUI-Custom-Scripts

# Install requirements
RUN cd custom_nodes/ComfyUI-MMAudio && pip install -r requirements.txt && \
    cd ../ComfyUI-WanVideoWrapper && pip install -r requirements.txt || true && \
    cd ../ComfyUI-GGUF && pip install -r requirements.txt || true && \
    cd ../cg-use-everywhere && pip install -r requirements.txt || true && \
    cd ../mikey_nodes && pip install -r requirements.txt || true && \
    cd ../ComfyUI-VideoHelperSuite && pip install -r requirements.txt || true && \
    cd ../rgthree-comfy && pip install -r requirements.txt || true && \
    cd ../ComfyUI-mxToolkit && pip install -r requirements.txt || true && \
    cd ../ComfyUI-PainterI2Vadvanced && pip install -r requirements.txt || true && \
    cd ../comfyui-various && pip install -r requirements.txt || true && \
    cd ../ComfyUI-Custom-Scripts && pip install -r requirements.txt || true

# Create model folders
RUN mkdir -p models/diffusion_models models/loras models/mmaudio models/upscale_models models/vae

RUN pip cache purge
