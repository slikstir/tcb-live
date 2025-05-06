import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["feedback"];

  initialize() {
    this.voteCount = 0;
    this.startTimer();
  }

  vote(event) {
    event.preventDefault();

    this.voteCount++;
    const button = event.currentTarget;
    const choiceId = button.dataset.choiceId;
    const pollId = button.dataset.pollId;

    // Store the choice and poll IDs for submission
    this.choiceId = choiceId;
    this.pollId = pollId;
  }

  startTimer() {
    // Submit votes every 2 seconds
    this.timer = setInterval(() => {
      if (this.voteCount > 0) {
        this.submitVote(this.choiceId, this.pollId);
      }
    }, 2000);
  }

  submitVote(choiceId, pollId) {
    if (!choiceId || !pollId) return; // Ensure IDs are set before submitting

    fetch("/votes", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        vote: {
          choice_id: choiceId,
          poll_id: pollId,
          count: this.voteCount
        }
      })
    })
      .then(response => {
        if (response.ok) {
          const messages = [
            "Your votes count - Keep Voting!",
            "Thanks for voting! Keep it up!",
            "Vote received! Tap again to vote more!",
            "Your vote is in! Keep going!",
            "Great job! Keep voting!"
          ];
          const randomMessage = messages[Math.floor(Math.random() * messages.length)];
          this.feedbackTarget.textContent = randomMessage;
        } else {
          this.feedbackTarget.textContent = "Error submitting your vote. Please try again.";
        }
        this.voteCount = 0; // Reset the vote count
      })
      .catch(() => {
        this.feedbackTarget.textContent = "Error submitting your vote. Please try again.";
        this.voteCount = 0; // Reset the vote count even if there's an error
      });
  }

  disconnect() {
    // Clear the timer when the controller is disconnected
    if (this.timer) {
      clearInterval(this.timer);
    }
  }
}