document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll(".helpful-btn").forEach((button) => {
    button.addEventListener("click", function () {
      const questionId = this.dataset.questionId;
      const userType = this.dataset.controller;
      toggleHelpful(questionId, userType);
    });
  });
});

function toggleHelpful(questionId, userType) {
  const button = document.querySelector(`[data-question-id="${questionId}"]`);
  const url = `/${userType}/questions/${questionId}/toggle_helpful`;

  fetch(url, {
    method: "POST",
    headers: {
      "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
    },
    body: new URLSearchParams({
      question_id: questionId,
    }),
  })
    .then((response) => response.json())
    .then((data) => {
      button.querySelector(".helpful-count").textContent = data.count;
      button.classList.toggle("btn-success");
      button.classList.toggle("btn-outline-secondary");
    });
}