#!/bin/bash

if [ -z "$MODEL" ]
then
    export MODEL=/models/llama-2-7b-chat.bin
    echo "MODEL environment variable not set, using $MODEL as default"
fi

export DEFAULT_MODEL=$MODEL

if [ -z "$MODEL_DOWNLOAD_URL" ]
then
    MODEL_DOWNLOAD_URL=https://huggingface.co/TheBloke/Nous-Hermes-Llama-2-7B-GGML/resolve/main/nous-hermes-llama-2-7b.ggmlv3.q4_0.bin
    echo "MODEL_DOWNLOAD_URL environment variable not set, using $MODEL_DOWNLOAD_URL as default"
fi

if [ ! -f $MODEL ]; then
    echo "Model file not found. Downloading..."
    curl -L -o $MODEL $MODEL_DOWNLOAD_URL
else
    echo "$MODEL model found."
fi

# Get the number of available threads on the system
n_threads=$(grep -c ^processor /proc/cpuinfo)

# Define context window
n_ctx=4096

# Define batch size
n_batch=2096
# If total RAM is less than 8GB, set batch size to 1024
total_ram=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')
if [ $total_ram -lt 8000000 ]; then
    n_batch=1024
fi

echo "Initializing server with:"
echo "Batch size: $n_batch"
echo "Number of CPU threads: $n_threads"
echo "Context window: $n_ctx"

# Start the first process
npm start &

# Start the second process
exec python3 -m llama_cpp.server --n_ctx $n_ctx --n_threads $n_threads --n_batch $n_batch