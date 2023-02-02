App = {
  web3Provider: null,
  contracts: {},

  init: async function () {
    // Load pets.
   /* $.getJSON("../pets.json", function (data) {
      var petsRow = $("#petsRow");
      var petTemplate = $("#petTemplate");

      for (i = 0; i < data.length; i++) {
        petTemplate.find(".panel-title").text(data[i].name);
        petTemplate.find("img").attr("src", data[i].picture);
        petTemplate.find(".pet-breed").text(data[i].breed);
        petTemplate.find(".pet-age").text(data[i].age);
        petTemplate.find(".pet-location").text(data[i].location);
        petTemplate.find(".btn-adopt").attr("data-id", data[i].id);

        petsRow.append(petTemplate.html())
        ;
      }
    })*/
    ;

    return await App.initWeb3();
  },

  initWeb3: async function () {
    // Modern dapp browsers...
    if (window.ethereum) {
      App.web3Provider = window.ethereum;
      try {
        // Request account access
        await window.ethereum.enable();
      } catch (error) {
        // User denied account access...
        console.error("User denied account access");
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = window.web3.currentProvider;
    }
    // If no injected web3 instance is detected, fall back to Ganache
    else {
      App.web3Provider = new Web3.providers.HttpProvider(
        "http://localhost:7545"
      );
    }

    return App.initContract();
  },

  initContract: function () {
    $.getJSON('StudentList.json', function(data) {
        // Get the necessary contract artifact file and instantiate it with @truffle/contract
        var SlArtifact = data;
        App.contracts.StudentList = TruffleContract(SlArtifact);

        // Set the provider for our contract
        App.contracts.StudentList.setProvider(App.web3Provider);

        // Use our contract to retrieve and mark the adopted pets
        //!probabilmente questo non dovremo farlo
        //return App.markAdopted();
      });

      $.getJSON('ExamList.json', function(data) {
        // Get the necessary contract artifact file and instantiate it with @truffle/contract
        var ElArtifact = data;
        App.contracts.ExamList = TruffleContract(ElArtifact);

        // Set the provider for our contract
        App.contracts.ExamList.setProvider(App.web3Provider);

        // Use our contract to retrieve and mark the adopted pets
        //!probabilmente questo non dovremo farlo
        //return App.markAdopted();
      });
    return App.bindEvents();
  },

  //! binda i bottoni di aggiunta studente con le funzioni che devono avere
  bindEvents: function () {
    $(document).on("click", "#btn-setStudent", App.addNewStudent);
    $(document).on("click", "#btn-setExam", App.handleNewExam);
  },

  //TODO rimuovere funzione poichè inutile per il nostro progetto/ui
  markAdopted: function () {
    var adoptionInstance;

    App.contracts.Adoption.deployed().then(function(instance) {
      adoptionInstance = instance;

      return adoptionInstance.getAdopters.call();
    }).then(function(adopters) {
      for (i = 0; i < adopters.length; i++) {
        if (adopters[i] !== '0x0000000000000000000000000000000000000000') {
          $('.panel-pet').eq(i).find('button').text('Success').attr('disabled', true);
        }
      }
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  //! cancellare anche questo se onn mostriamo gli studenti
  addNewStudent: function (event) {
    event.preventDefault();

    var adoptionInstance;

    window.web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }
      var account = accounts[0];
      App.contracts.StudentList.deployed().then(function(instance) {
        adoptionInstance = instance;
        var studentId = document.getElementById("stdMatricola").value;
        var stdName = document.getElementById("stdName").value;
        var stdSurname = document.getElementById("stdName").value;
        console.log(studentId);
        if (App.validateField(studentId) && App.validateField(stdName) && App.validateField(stdSurname))
            return adoptionInstance.addStudent(stdName, stdSurname, studentId, {from: account});
        else
          window.alert("Tutti i campi del form AGGIUNGI STUDENTE devono essere compilati");
      }).then(function(result){
        window.alert("STUDENTE AGGIUNTO CON SUCCESSO");

      })
      .catch(function(err) {
        console.log(err.message);
        if (err.message.includes("permesso"))
           window.alert("non hai il permesso di eseguire quest'azione");
        else
          window.alert("esiste già un utente con questa matricola");
      });
    });
  },

  validateField: function(value){
    return !(value == null || value == "");

  },

  //! cancellare anche questo se non mostriamo gli esami
  handleNewExam: function (event) {
    event.preventDefault();

    var adoptionInstance;

    window.web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }
      var account = accounts[0];
      App.contracts.ExamList.deployed().then(function(instance) {
        adoptionInstance = instance;
        var exName = document.getElementById("exName").value;
        var exId = document.getElementById("exId").value;
        var exMark = document.getElementById("mark").value;
        var studentId = document.getElementById("ex-studentId").value;
        if (App.validateField(exName) && App.validateField(exId) && App.validateField(exMark) && App.validateField(studentId))
          return adoptionInstance.addExam(exName, exId, exMark, studentId, {from: account});
        else
          window.alert("Tutti i campi del form AGGIUNGI ESAME devono essere compilati");

      }).then(function(result) {
        console.log(result);
        window.alert("ESAME AGGIUNTO CON SUCCESSO");
      }).catch(function(err) {
        console.log(err.message);
        if (err.message.includes("permesso"))
           window.alert("non hai il permesso di eseguire quest'azione");
        else if (err.message.includes("studente"))
          window.alert("lo studente non esiste");
        else
          window.alert("ESAME AGGIUNTO CON SUCCESSO");

      });
    });
  },
};

$(function () {
  $(window).load(function () {
    App.init();
  });
});
