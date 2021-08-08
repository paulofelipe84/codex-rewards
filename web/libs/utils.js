import server from './server'
import abi from 'ethjs-abi'

export default {
  findIndexByName (abiJson, name) {
    return abiJson.findIndex(function (item) {
      return item.name === name
    })
  },
  async callContractFunction (contractAddress, abiJson, functionName, params) {
    const encodedData = abi.encodeMethod(
      abiJson[
        this.findIndexByName(
          abiJson,
          functionName,
        )
      ],
      params,
    ).substr(2)
    var encodedResult = await server.currentNode().callContract(contractAddress, encodedData)
    encodedResult = '0x' + encodedResult

    return abi.decodeMethod(abiJson[this.findIndexByName(abiJson, functionName)], encodedResult)
  },
  encodeContractSendFunction(abiJson, functionName, params){
    return abi.encodeMethod(
      abiJson[this.findIndexByName(abiJson, functionName)], 
      params
    ).substr(2);
  },
}