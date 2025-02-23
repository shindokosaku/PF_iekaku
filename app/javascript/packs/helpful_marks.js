/*HTMLが読み込み完了したら関数を実行する*/
//document.addEventListener("turbolinks:load", function () {
  document.querySelectorAll(".helpful-btn").forEach(button => {
    /*クリックした時に関数内の処理を実行する*/
    button.addEventListener("click", function () {
      const questionId = this.dataset.questionId;
      let controller = this.dataset.controller;  // 'public' or 'admin'
      /*controllerとquestionIdを組み合わせてリクエストURLを作成*/
      if (controller == "public"){
        controller= "";
      }
      else if (controller == "admin"){
        controller= "admin/";
      }
      const url = `/${controller}questions/${questionId}/toggle_helpful.json`;

      /*toggle_helpfulアクションの非同期化*/
      fetch(url, {
        method: "POST",
        headers: {
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
          "Content-Type": "application/json"
        },
        credentials: "same-origin",
        body: JSON.stringify({})
      })
        .then(response => response.json())
        .then(data => {
          /*ボタンの色を変更*/
          console.log(data);
          if (data.liked === true) {
            this.classList.remove("btn-outline-secondary");
            this.classList.add("btn-success");
          } else {
            this.classList.remove("btn-success");
            this.classList.add("btn-outline-secondary");
          }
          /*参考になった数を更新*/
          this.querySelector(".helpful-count").textContent = data.count;
        })
        .catch(error => console.error("Error:", error));
    });
  });
//});

