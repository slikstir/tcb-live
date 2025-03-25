function initVoteFormBehavior() {
  const form = document.querySelector('form');
  if (!form) return;

  const radios = form.querySelectorAll('input[type=radio][name="vote[choice_id]"]');
  const submitBtn = document.getElementById('vote-submit');
  const labels = form.querySelectorAll('label[for^="vote_choice_"]');

  labels.forEach(label => {
    label.addEventListener('click', (event) => {
      const inputId = label.getAttribute('for');
      const input = document.getElementById(inputId);

      if (input) {
        input.checked = true;
        submitBtn.disabled = false;

        // Clear all selected/not-selected from all labels
        labels.forEach(l => {
          l.classList.add('not-selected');
        });

        // Remove not-selected for matching label(s)
        const matchingLabels = Array.from(labels).filter(l => l.getAttribute('for') === inputId);
        matchingLabels.forEach(matchingLabel => {
          matchingLabel.classList.remove('not-selected');
        });
      }
    });
  });
}

// Register for both initial load and Turbo page loads
document.addEventListener('DOMContentLoaded', initVoteFormBehavior);
document.addEventListener('turbo:load', initVoteFormBehavior);
