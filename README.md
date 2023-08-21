<p align="center">
  <a href="https://apps.umbrel.com/app/llama-gpt">
    <img width="150" height="150" src="https://i.imgur.com/LI59cui.png" alt="OpenLLM" width="200" />
  </a>
</p>
<p align="center">
  <h1 align="center">OpenLLM</h1>
  <p align="center">
    A self-hosted, offline, ChatGPT-like chatbot with different LLM support. 100% private, with no data leaving your device.
  </p>
</p>

## How to install

---

### Install OpenLLM anywhere else with Docker

You can run OpenLLM on any x86 system. Make sure you have Docker installed.

Then, clone this repo and `cd` into it:

```
git clone https://github.com/edgar971/open-chat.git
cd open-chat
```

You can now run OpenLLM with any of the following models depending upon your hardware:

| Model size | Model used                          | Minimum RAM required | How to start OpenLLM                            |
| ---------- | ----------------------------------- | -------------------- | ------------------------------------------------ |
| 7B         | Nous Hermes Llama 2 7B (GGML q4_0)  | 8GB                  | `docker compose up -d`                           |
| 13B        | Nous Hermes Llama 2 13B (GGML q4_0) | 16GB                 | `docker compose -f docker-compose-13b.yml up -d` |
| 70B        | Meta Llama 2 70B Chat (GGML q4_0)   | 48GB                 | `docker compose -f docker-compose-70b.yml up -d` |

You can access OpenLLM at `http://localhost:3000`.

To stop OpenLLM, run:

```
docker compose down
```

---

## API Configuration

Additional settings can be found [here](https://github.com/abetlen/llama-cpp-python/blob/main/llama_cpp/server/app.py#L23) and added as env variables or arguments to the run.sh (--n_ctx 12) script. 

Example:

```yml
version: '3'
services:
  api:
    image: ghcr.io/edgar971/open-chat-cuda:latest
    environment:
      - MODEL=/path/to/your/model
      - N_CTX=4096
    ports:
```

## Acknowledgements

A massive thank you to the following developers and teams for making OpenLLM possible:

- [Mckay Wrigley](https://github.com/mckaywrigley) for building [Chatbot UI](https://github.com/mckaywrigley).
- [Georgi Gerganov](https://github.com/ggerganov) for implementing [llama.cpp](https://github.com/ggerganov/llama.cpp).
- [Andrei](https://github.com/abetlen) for building the [Python bindings for llama.cpp](https://github.com/abetlen/llama-cpp-python).
- [NousResearch](https://nousresearch.com) for [fine-tuning the Llama 2 7B and 13B models](https://huggingface.co/NousResearch).
- [Tom Jobbins](https://huggingface.co/TheBloke) for [quantizing the Llama 2 models](https://huggingface.co/TheBloke/Nous-Hermes-Llama-2-7B-GGML).
- [Meta](https://ai.meta.com/llama) for releasing Llama 2 under a permissive license.


