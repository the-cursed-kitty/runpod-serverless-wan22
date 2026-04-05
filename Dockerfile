FROM runpod/worker-comfyui:5.8.5-base

WORKDIR /comfyui

# System dependencies for MMAudio + video/audio
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsndfile1 \
    espeak-ng \
    && rm -rf /var/lib/apt/lists/*

# Clone every custom node your workflow actually uses
RUN git clone https://github.com/kijai/ComfyUI-MMAudio.git custom_nodes/ComfyUI-MMAudio && \
    git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git custom_nodes/ComfyUI-WanVideoWrapper && \
    git clone https://github.com/Comfy-Org/ComfyUI-GGUF.git custom_nodes/ComfyUI-GGUF && \
    git clone https://github.com/chrisgoringe/cg-use-everywhere.git custom_nodes/cg-use-everywhere && \
    git clone https://github.com/mikemikemikemike/mikey_nodes.git custom_nodes/mikey_nodes && \
    git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git custom_nodes/ComfyUI-VideoHelperSuite && \
    git clone https://github.com/rgthree/rgthree-comfy.git custom_nodes/rgthree-comfy && \
    git clone https://github.com/Smirnov75/ComfyUI-mxToolkit.git custom_nodes/ComfyUI-mxToolkit && \
    git clone https://github.com/princepainter/ComfyUI-PainterI2Vadvanced.git custom_nodes/ComfyUI-PainterI2Vadvanced && \
    git clone https://github.com/jamesWalker55/comfyui-various.git custom_nodes/comfyui-various && \
    git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git custom_nodes/ComfyUI-Custom-Scripts

# Install requirements (especially MMAudio which was failing before)
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

# Create folders for models (they will live on the Network Volume)
RUN mkdir -p models/diffusion_models models/loras models/mmaudio models/upscale_models

RUN pip cache purge
