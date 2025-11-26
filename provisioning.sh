#!/bin/bash
set -e  # Exit on any error

echo "=== Starting provisioning ==="

echo "Downloading extensions..."
mkdir -p /app/extensions

git clone "https://github.com/Bing-su/adetailer.git" "/app/extensions/adetailer"

# Qwen-Image checkpoints
echo "Downloading models..."
mkdir -p /app/models/Stable-diffusion

xargs -n 1 -P 3 wget --content-disposition --trust-server-names --no-verbose --no-clobber --header="Authorization: Bearer ${TOKEN_HUGGINGFACE_API}" -P "/app/models/Stable-diffusion" <<< "
https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/diffusion_models/qwen_image_fp8_e4m3fn.safetensors
https://huggingface.co/Comfy-Org/Qwen-Image-Edit_ComfyUI/resolve/main/split_files/diffusion_models/qwen_image_edit_2509_fp8_e4m3fn.safetensors
"

echo "Downloading text encoders..."
mkdir -p /app/models/text_encoder

xargs -n 1 -P 3 wget --content-disposition --trust-server-names --no-verbose --no-clobber --header="Authorization: Bearer ${TOKEN_HUGGINGFACE_API}" -P "/app/models/text_encoder" <<< "
https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors
"

# echo "Downloading LoRAs..."
mkdir -p /app/models/Lora

# Qwen-Image LORA
xargs -n 1 -P 3 wget --content-disposition --trust-server-names --no-verbose --no-clobber --header="Authorization: Bearer ${TOKEN_HUGGINGFACE_API}" -P "/app/models/Lora" <<< "
https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Lightning-4steps-V2.0.safetensors
https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Lightning-4steps-V1.0.safetensors
https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Lightning-8steps-V1.0.safetensors
https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Edit-2509/Qwen-Image-Edit-2509-Lightning-4steps-V1.0-bf16.safetensors
https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Edit-2509/Qwen-Image-Edit-2509-Lightning-8steps-V1.0-bf16.safetensors
https://huggingface.co/Daverrrr75/Qwen-Lora-Lenovo-Ultrareal/resolve/main/lenovo.safetensors
https://huggingface.co/Instara/1girl-qwen-image/resolve/main/1GIRL_QWEN_V2.safetensors
https://huggingface.co/starsfriday/Qwen-Image-NSFW/resolve/main/qwen_image_nsfw.safetensors
"

# Qwen-Image LORA
# xargs -n 1 -P 3 wget --content-disposition --trust-server-names --no-verbose -P "/app/models/Lora" <<< "
# https://civitai.com/api/download/models/2195978?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2363467?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2106185?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2292091?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2105899?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2270374?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2373044?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2316696?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2181911?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2108245?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2289403?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2335968?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2394653?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2171888?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2201491?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2232791?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2327746?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2358787?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2183295?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2211804?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2183253?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2407075?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2137968?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2257724?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2357409?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2408439?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2280034?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2196278?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# https://civitai.com/api/download/models/2256755?type=Model&format=SafeTensor&token=${TOKEN_CIVITAI_API}
# "

# echo "Downloading VAE..."
# mkdir -p /app/models/VAE

xargs -n 1 -P 3 wget --content-disposition --trust-server-names --no-verbose --no-clobber --header="Authorization: Bearer ${TOKEN_HUGGINGFACE_API}" -P "/app/models/VAE" <<< "
https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors"

echo "=== Provisioning complete ==="