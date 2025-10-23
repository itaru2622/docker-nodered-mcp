ARG base=itaru2622/mcp:trixie
FROM ${base}
ARG base=itaru2622/mcp:trixie

# https://github.com/langchain-ai/langgraphjs/blob/main/docs/docs/agents/mcp.md
RUN npm install -g  @langchain/core langchain @langchain/langgraph @langchain/mcp-adapters @langchain/openai  tsx

# add nod-red
RUN npm install -g --unsafe-perm node-red
# add typescript on node-red
RUN npm install -g node-red-dashboard node-red-contrib-ts \
                   openapi-red @thingweb/node-red-node-wot node-red-nodegen

# module using node-red function needs to be located in top of node-red-home/node_modules/
RUN (mkdir -p /root/.node-red; cd /root/.node-red; npm install @langchain/core langchain @langchain/langgraph @langchain/mcp-adapters @langchain/openai )
#
# then you can import above modules in setup tab in function node as below: 
#  Module name:                     import as
#  @langchain/mcp-adapters          langchainMcpAdapters             // BUT NOT import { MultiServerMCPClient } from "@langchain/mcp-adapters";
#  @langchain/langgraph/prebuilt    langchainLanggraphPrebuilt
#  langchain/chat_models/universal  langchainChatModelsUniversal
#
# then use above modules in OnMessage tab in function node as below:
#
# const MultiServerMCPClient = langchainMcpAdapters.MultiServerMCPClient;
# const createReactAgent     = langchainLanggraphPrebuilt.createReactAgent;
# const initChatModel        = langchainChatModelsUniversal.initChatModel
# msg.payload = { MultiServerMCPClient, createReactAgent, initChatModel };
# return msg;

# nodered alternatives
RUN npm install -g n8n
RUN npm install -g pnpm turbo typescript @types/node
