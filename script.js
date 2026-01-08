document.addEventListener('DOMContentLoaded', function() {

    const learnMoreButton = document.querySelector('.button');

    const booksSection = document.querySelector('.view2');

    const arrow = document.querySelector('.arrow2');

    const view3Section = document.querySelector('.view3');

 

    if (learnMoreButton && booksSection && arrow && view3Section) {
 
        learnMoreButton.addEventListener('click', function(event) {

            event.preventDefault();

            booksSection.scrollIntoView({ behavior: 'smooth' });

        });

 

        arrow.addEventListener('click', function(event) {

            event.preventDefault();

            view3Section.scrollIntoView({ behavior: 'smooth' });

        });

    }

});