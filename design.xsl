<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
     <!-- Specifies the output format as HTML, sets the document type for compatibility,
         specifies the character encoding as UTF-8, and enables indentation for readability -->
    <xsl:output method="html" doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes"/>
    
    <!-- Main template that matches the root of the XML document.
         This is where the HTML structure is created. -->
    <xsl:template match="/">
        <html>
        <head>
            <title>Book List</title> 
        <style>

                 <!-- styles are defined here for the entire page layout, including
                   body, headers, book containers, and interactive elements like hover effects. -->
                

                <!-- Resets margin, padding, and border for several HTML elements to ensure consistency -->
                body, h1, h2, table, th, td, p, img {
                    margin: 0;
                    padding: 0;
                    border: 0;
                }
                
                <!-- Sets the page's background color, font, and base margins -->
                body {
                    font-family: Arial, sans-serif;
                    background-color: #FAF0E6;
                    color: #333;
                    margin: 20px;
                }
               
               <!-- Additional styles are provided for book containers, images,
                   details, description popups, and hover effects to enhance the UI. -->
				
                <!-- Styling for book container -->
                .book-container {
                    width: 200px;  <!-- Set width for each book container -->
                    display: inline-block;
                    margin: 10px;
                    padding: 10px;
                    border: 1px solid #ddd;
                    cursor: pointer;
                    position: relative;
                }

                <!-- Styling for book images -->
                .book-image {
                    width: 100%;  <!-- Make image responsive -->
                    height: auto;
                }

                <!-- Styling for book details -->
                .book-details {
                    display: none; <!-- Hide book details by default -->
                    position: absolute;
                    bottom: 0;
                    left: 0;
                    right: 0;
                    background-color: rgba(255, 255, 255, 0.9);
                    padding: 10px;
                    border-top: 1px solid #ddd;
                    border-radius: 5px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                    transition: opacity 0.3s, transform 0.3s; <!-- Add transition for smooth appearance -->
                    z-index: 1;
                }

                <!-- Styling for book title -->
                .book-title {
                    font-weight: bold;
                    margin-bottom: 5px;
                }

                <!-- Styling for book information -->
                .book-info {
                    font-size: 12px;
                }

                <!--Styling for book description popup -->
                .description-popup {
                    display: none;   <!-- Hide description popup by default -->
                    position: absolute;
                    top: 0;
                    left: calc(100% + 10px); <!-- Position popup to the right of the book container -->
                    width: 200px; <!-- Set width for the popup -->
                    background-color: #e4a135;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                    padding: 10px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                    z-index: 2;
                }

                <!-- Styling for book description -->
                .book-description {
                    font-size: 12px;
                    margin-top: 10px;
                }

                <!-- Styling for rating stars -->
                .rating {
                    color: black;
                }

                <!-- Hover effect to display book details -->
                .book-container:hover .book-details {
                    display: block; <!-- Show book details on hover -->
                    opacity: 1;  <!-- Make book details fully visible -->
                    transform: translateY(-10px);  <!-- Move book details slightly upwards -->
                }

                <!-- Hover effect to display description popup -->
                .learn-more:hover + .description-popup {
                    display: block;  <!-- Show description popup on hover -->
                }

                <!-- Styling for heart and cart icons -->
                .icon {
                    font-size: 24px;
                    cursor: pointer;
                    margin-right: 10px;
                    transition: color 0.3s; <!-- Add transition for color change -->
                }

                <!-- Styling for red heart -->
                .liked {
                    color: red;
                }

                .learn-more {
                    font-size: 14px;
                    color: #008080;
                    cursor: pointer;
                }

                <!-- Footer styles -->
				.footer_main {
                    display: flex;
                    justify-content: space-around;
                    padding: 20px;
                    background-color: #333;
                }

                .footer_main .tag {
                    display: flex;
                    flex-direction: column;
                }

                .footer_main .tag h1 {
                    margin-bottom: 10px;
                     color: #e4a135; 
                }

                .footer_main a {
                    margin: 5px 0;
                    text-decoration: none;
                    color: #f2f2f2;
                }

                .social_link a {
                    display: inline-block;
                    margin-right: 10px;
                }

                .bottompg {
                    text-align: center;
                    padding: 10px;
                    background-color: #000000;
                    color: #e4a135; 
                }


                <!-- Header styles -->
                header {
                    background-color: #333;
                    color: #333;
                    padding: 10px;
                    text-align: center;
                }

                .header-logo img {
                    width: 100px;
                    height: auto;
                }

                nav {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    background-color: #333;
                    padding: 1rem;
                }

                .logo h1 {
                    margin: 0; <!-- Logo text styling -->
                }

                .logo img {
                    width: 100px; <!-- Adjust logo image size as needed -->
                    height: auto;
                }

                nav input[type="text"] {
                    padding: 0.5rem;
                    margin-right: 1rem; <!-- Styling for the search bar -->
                }

                nav ul {
                    list-style: none; <!-- Remove default list styling -->
                    display: flex;
                    margin: 0;
                    padding: 0;
                }

                nav ul li {
                    padding: 0 1rem; <!-- Spacing between menu items -->
                }

                nav ul li a {
                    text-decoration: none; <!-- Remove underline from links -->
                    color: #333; <!-- Link color -->
                }

                nav button {
                    background: none;
                    border: none;
                    cursor: pointer;
                }
				
				<!--Additional styles for the ribbon and best-selling books-->
                .pull-me-ribbon {
				 
                    position: fixed;
                    top: 50%;
                    right: 0;
                    transform: translateY(-50%);
                    width: 150px;
                    background-color: #333;
                    color: white;
                    text-align: center;
                    padding: 10px;
                    border-top-left-radius: 20px;
                    border-bottom-left-radius: 20px;
                    cursor: pointer;
                    z-index: 9999; <!--Ensure it's above other content-->
                }

                .best-selling-books {
				    
                    position: fixed;
                    top: 0;
                    right: 150px; <!-- Adjust based on ribbon width -->
                    width: 300px; <!-- Adjust based on desired width -->
                    background-color: white;
                    padding: 20px;
                    border-top-left-radius: 20px;
                    border-bottom-left-radius: 20px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
					transition: transform 0.3s ease-in-out;
                    visibility: hidden; <!--   Initially hide the section -->
                    opacity: 0; <!-- Initially set opacity to 0 -->
					
                    z-index: 999; <!-- Ensure it's above other content -->
                }

                .best-selling-books.show {
                    right: 0;  <!-- Display the best-selling books by moving it to the right -->
					visibility: visible; <!-- Show the section -->
                    opacity: 1; <!-- Set opacity to fully visible -->
                }
				
        </style>
			
			<script>
                <!--JavaScript functions for interactive behavior, such as
                   toggling the visibility of book details or changing heart icon color. -->
                   
                <!-- Function to toggle the display of best-selling books section -->

                function toggleBestSellingBooks() {
                    var bestSellingBooks = document.getElementById("best-selling-books");
                    bestSellingBooks.classList.toggle("show");
                }
				
				<!-- Event listener to activate the toggle function when the 'Pull Me' ribbon is clicked -->
                document.addEventListener('DOMContentLoaded', function() {
                   var ribbon = document.querySelector('.pull-me-ribbon');
                   ribbon.addEventListener('click', toggleBestSellingBooks);
                });
				
            </script>
			
        </head>
        <body>
       <header>  <!-- Navigation and search bar setup -->
                
    <!-- Wrap the title and the image inside an "<a>" tag pointing to the main page -->
          <div class="logo">
              <a href="bookstore.html" class="menu">  
                 <h1>Les Mots Magiques</h1>
              </a>
          </div>
           <!-- Input for search bar -->
           <input type="text" name="search" placeholder="Search.."/> 
           <!-- Navigation links and icons for user interaction -->
           <nav>    
               <ul>
                 <li><a href="#"><button id="btn1"><i class="fa-solid fa-heart"></i></button></a></li>
                 <li><a href="#"><button id="btn2"><i class="fa-solid fa-cart-shopping"></i></button></a></li>
               </ul>
          </nav>
      </header>

			
            <h2>Romance</h2>
            <xsl:apply-templates select="BookList/Book[Genre = 'Romance']"/>
            
            <h2>Humor</h2>
            <xsl:apply-templates select="BookList/Book[Genre = 'Humor']"/>
            
		    <h2>Young adult</h2>
            <xsl:apply-templates select="BookList/Book[Genre = 'Young adult']"/>
			
			<h2>Education</h2>
            <xsl:apply-templates select="BookList/Book[Genre = 'Education']"/>
			
			<h2>Literature</h2>
            <xsl:apply-templates select="BookList/Book[Genre = 'Literature']"/>
			
			
			<h2>Non-fiction</h2>
            <xsl:apply-templates select="BookList/Book[Genre = 'Non-fiction']"/>
            <!-- Add more sections for other genres as needed -->
			
			 <!-- Pull Me Ribbon and Best Selling Books section for interactive user engagement -->
            <div class="pull-me-ribbon" onclick="toggleBestSellingBooks()">Pull Me</div>
            <!-- Display best-selling books -->
            <div id="best-selling-books" class="best-selling-books">
                <h2>Best Selling Books</h2>
                <ul>
                    <!-- Add best-selling books dynamically using XSLT -->
                    <xsl:apply-templates select="BookList/Book[BestSeller = 'true']"/>
                </ul>
            </div>
			
            <footer>
                <div class="footer_main">
                    <div class="tag">
                        <h1>Links</h1>
                        <a href="#">Home</a>
                        <a href="#">Our Books</a>
                        <a href="#">Books</a>
                        <a href="#">Contact</a>
                    </div>
                    <div class="tag">
                        <h1>Contact Info</h1>
                        <a href="#"><i class="fa-solid fa-phone"></i>+230 5687 3498</a>
                        <a href="#"><i class="fa-solid fa-envelope"></i>lesmotsmagiques@gmail.com</a>
                    </div>
                    <div class="tag">
                        <h1>Follow us</h1>
                        <div class="social_link">
                            <a href="https://www.facebook.com"><i class="fa-brands fa-square-facebook"></i></a>
                            <a href="https://www.instagram.com"><i class="fa-brands fa-instagram"></i></a>
                            <a href="https://www.twitter.com"><i class="fa-brands fa-twitter"></i></a>
                        </div>
                    </div>
                </div>
                <div class="bottompg">
                    <p>© 2024 Les Mots Magiques.</p>
                </div>
            </footer>
			 
			
			
            <script>
                function toggleHeartColor(element) {
                    element.classList.toggle('liked'); <!-- Toggle 'liked' class on click -->
                }
				
            </script>
			
			
			
        </body>
		
        </html>
    </xsl:template>

    <!-- Template to display books -->
<xsl:template match="Book">
        <div class="book-container">
            <!-- Display structure for individual books with image, title, author, etc. 
             Interactive elements like hover details and rating stars are included -->
        </div>
            <img class="book-image" src="{Image}" alt="{Title} cover image" />
            <div class="book-details">
                <p class="book-title"><xsl:value-of select="Title"/></p>
                <p class="book-info">Author: <xsl:value-of select="Author"/></p>
                <p class="book-info">ISBN: <xsl:value-of select="ISBN"/></p>
                <p class="book-info">Year: <xsl:value-of select="PublicationYear"/></p>
				<p class="book-info">Date: <xsl:value-of select="PublicationYear"/></p>
                <p class="book-info">Genre: <xsl:value-of select="Genre"/></p>
                <p class="book-info">Price: <xsl:value-of select="Price"/></p>
                <span class="learn-more">Learn More</span>
                <div class="description-popup">
                    <p class="book-description"><xsl:value-of select="Description"/></p>
                    <!-- Rating stars -->
                    <div class="rating">
                        <span>&#9733;</span>
                        <span>&#9733;</span>
                        <span>&#9733;</span>
                        <span>&#9733;</span>
                        <span>&#9734;</span>
                    </div>
                </div>
                <div>
                    <!-- Heart icon for liking -->
                    <span class="icon" onclick="toggleHeartColor(this)">&#x2665;</span>
                    <!-- Cart icon for buying -->
                    <span class="icon">&#x1F6D2;</span>
                </div>
            </div>
        
    </xsl:template>
</xsl:stylesheet>