#!/bin/bash

if [ -z "$MODEL" ]
then
    export MODEL=/models/llama-2-7b-chat.gguf
    echo "MODEL environment variable not set, using $MODEL as default"
fi

export DEFAULT_MODEL=$MODEL

if [ -z "$MODEL_DOWNLOAD_URL" ]
then
    MODEL_DOWNLOAD_URL=https://huggingface.co/TheBloke/Nous-Hermes-Llama-2-7B-GGUF/resolve/main/nous-hermes-llama-2-7b.Q4_0.gguf
    echo "MODEL_DOWNLOAD_URL environment variable not set, using $MODEL_DOWNLOAD_URL as default"
fi

if [ ! -f $MODEL ]; then
    echo "Model file not found. Downloading..."
    curl -L -o $MODEL $MODEL_DOWNLOAD_URL
else
    echo "$MODEL model found."
fi

# Get the number of available threads on the system
if [ -z "$N_THREADS" ];
then
    n_threads=$(grep -c ^processor /proc/cpuinfo)
else
    n_threads="$N_THREADS"
fi


# Define context window
if [ -z "$CTX_SIZE" ];
then
    n_ctx=4096
else
    n_ctx="$CTX_SIZE"
fi


# Define batch size
if [ -z "$BATCH_SIZE" ];
then
    n_batch=2096
    # If total RAM is less than 8GB, set batch size to 1024
    total_ram=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')
    if [ $total_ram -lt 8000000 ]; then
        n_batch=1024
    fi
else
    n_batch="$BATCH_SIZE"
fi

# Inform the user about the silly breaks
echo ""
echo "Note: Model MUST be in GGUF format due to a break in llama.cpp. If you were using the default model" \
    "just clear the MODEL environment variable, or set it to the default /models/llama-2-7b-chat.gguf."
echo ""

echo "Initializing server with:"
echo "Batch size: $n_batch"
echo "Number of CPU threads: $n_threads"
echo "Context window: $n_ctx"

# Start the first process
npm start &

# Start the second process
exec python3 -m llama_cpp.server --n_ctx $n_ctx --n_threads $n_threads --n_batch $n_batch