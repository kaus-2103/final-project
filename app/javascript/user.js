document.addEventListener("DOMContentLoaded", function() {
    // Select all checkbox
    const selectAllCheckbox = document.getElementById('select-all-checkbox');
  
    // Individual user checkboxes
    const userCheckboxes = document.querySelectorAll('.user-checkbox');
  
    // Add event listener for select all checkbox
    selectAllCheckbox.addEventListener('change', function() {
      userCheckboxes.forEach(function(checkbox) {
        checkbox.checked = selectAllCheckbox.checked;
      });
    });
  
    // Function to get selected user IDs
    function getSelectedUserIds() {
      const selectedUserIds = [];
      userCheckboxes.forEach(function(checkbox) {
        if (checkbox.checked) {
          selectedUserIds.push(checkbox.value);
        }
      });
      return selectedUserIds;
    }
  
    // Button actions
    const blockButton = document.getElementById('block-button');
    const unblockButton = document.getElementById('unblock-button');
    const addAdminButton = document.getElementById('add-admin-button');
    const removeAdminButton = document.getElementById('remove-admin-button');
    const deleteButton = document.getElementById('delete-button');
  
    blockButton.addEventListener('click', function() {
      const selectedUserIds = getSelectedUserIds();
      // Send selectedUserIds to server to block users
    });
  
    // Implement similar event listeners for other buttons
  });
  