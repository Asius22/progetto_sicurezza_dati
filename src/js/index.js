async function connectWallet(){
    account = await  window.ethereum.request({method: "eth_requestAccounts"}).catch(err => {
        console.log(err.code);
    });

    console.log(account)
}