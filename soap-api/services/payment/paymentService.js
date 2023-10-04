const Payment = require("../../models/Payment.js");

module.exports = {
    PaymentService: {
      PaymentPort: {
        InitiatePayment: async function  (args) {
          let payment = args;
          payment.products = payment.products.products;
          if( payment.products.length==null){
            payment.products._id = null;
            payment.products = [payment.products];
          }
          let paymentBD =  Payment(payment);
          // console.log(response);
          await paymentBD.save();
          console.log(paymentBD);
          var transactionId = paymentBD._id.toString(); 
          return {
            transactionId: transactionId,
          };
        },
        Payments:async function(args){
          // console.log("ENTRANDOASD ASD ASD");
          let paymentsBD = await Payment.find({userId:args["userId"]});
          console.log(paymentsBD,"asdasdasd",args["userId"]);
          let payments = [];
          for(let payment of paymentsBD){
            console.log("DARTATATAT",payment.date);
            for(let producto of payment.products){
              payments.push({"title":producto.name,"quantity":producto.quantity,"price":producto.price,"date":payment.date.toLocaleString()});
            }
          }
    
          console.log("CAASDSAD",payments);
          return {
            payments
          }
        }
      },
    },
  };