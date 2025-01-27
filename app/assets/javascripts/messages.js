document.addEventListener("DOMContentLoaded", () => {
  const deleteButtons = document.querySelectorAll(".delete-message-btn");
  const deleteModal = document.getElementById("deleteMessageModal");
  const confirmDeleteButton = document.getElementById("confirmDeleteMessageBtn");

  deleteButtons.forEach((button) => {
    button.addEventListener("click", (event) => {
      const messageId = button.dataset.messageId;
      confirmDeleteButton.href = `/admin/messages/${messageId}`; // 削除リクエストURL
      $(deleteModal).modal("show");
    });
  });
});