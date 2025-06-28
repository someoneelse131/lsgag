// Mobile Navigation Toggle
const hamburger = document.querySelector('.hamburger');
const navMenu = document.querySelector('.nav-menu');

hamburger.addEventListener('click', () => {
    navMenu.classList.toggle('active');
});

// Close mobile menu when clicking on nav links
document.querySelectorAll('.nav-link').forEach(link => {
    link.addEventListener('click', () => {
        navMenu.classList.remove('active');
    });
});

// Smooth scrolling for navigation links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Service card flip function
function flipCard(card) {
    card.classList.toggle('flipped');
}

// Add scroll effect to navbar
window.addEventListener('scroll', () => {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 100) {
        navbar.style.background = 'rgba(255,255,255,0.95)';
        navbar.style.backdropFilter = 'blur(10px)';
    } else {
        navbar.style.background = 'var(--bg-white)';
        navbar.style.backdropFilter = 'none';
    }
});

// Form submission
const contactForm = document.getElementById('contactForm');
if (contactForm) {
    contactForm.addEventListener('submit', async (e) => {
        e.preventDefault();

        // Get form data
        const formData = new FormData(contactForm);
        const data = {
            name: formData.get('name'),
            email: formData.get('email'),
            phone: formData.get('phone'),
            message: formData.get('message')
        };

        // Here you can add code to send data to your backend/database
        // For example:
        // try {
        //     const response = await fetch('/api/contact', {
        //         method: 'POST',
        //         headers: {
        //             'Content-Type': 'application/json',
        //         },
        //         body: JSON.stringify(data)
        //     });
        //
        //     if (response.ok) {
        //         alert('Vielen Dank für Ihre Nachricht! Wir werden uns umgehend bei Ihnen melden.');
        //         contactForm.reset();
        //     } else {
        //         alert('Es gab einen Fehler beim Senden Ihrer Nachricht. Bitte versuchen Sie es später erneut.');
        //     }
        // } catch (error) {
        //     console.error('Error:', error);
        //     alert('Es gab einen Fehler beim Senden Ihrer Nachricht. Bitte versuchen Sie es später erneut.');
        // }

        // For now, just show a success message
        alert('Vielen Dank für Ihre Nachricht! Wir werden uns umgehend bei Ihnen melden.');
        contactForm.reset();
    });
}

// Intersection Observer for fade-in animations
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -100px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('fade-in-visible');
        }
    });
}, observerOptions);

// Observe all sections for animation
document.addEventListener('DOMContentLoaded', () => {
    const sections = document.querySelectorAll('section');
    sections.forEach(section => {
        section.classList.add('fade-in');
        observer.observe(section);
    });
});

// Dynamic year in footer
const currentYear = new Date().getFullYear();
const yearElement = document.querySelector('footer p');
if (yearElement) {
    yearElement.innerHTML = yearElement.innerHTML.replace('2025', currentYear);
}

// Load services from database (example function)
async function loadServices() {
    // This function can be used to load services from your MySQL database
    // Example:
    // try {
    //     const response = await fetch('/api/services');
    //     const services = await response.json();
    //
    //     const servicesGrid = document.querySelector('.services-grid');
    //     servicesGrid.innerHTML = '';
    //
    //     services.forEach(service => {
    //         const serviceCard = createServiceCard(service);
    //         servicesGrid.appendChild(serviceCard);
    //     });
    // } catch (error) {
    //     console.error('Error loading services:', error);
    // }
}

// Create service card element (helper function)
function createServiceCard(service) {
    const card = document.createElement('div');
    card.className = 'service-card';
    card.onclick = () => flipCard(card);

    card.innerHTML = `
        <div class="card-inner">
            <div class="card-front">
                <div class="service-icon">${service.icon}</div>
                <h3>${service.title}</h3>
            </div>
            <div class="card-back">
                <p>${service.description}</p>
            </div>
        </div>
    `;

    return card;
}

// Load job listings from database (example function)
async function loadJobs() {
    // This function can be used to load job listings from your MySQL database
    // Example:
    // try {
    //     const response = await fetch('/api/jobs');
    //     const jobs = await response.json();
    //
    //     const jobList = document.querySelector('.job-list');
    //     jobList.innerHTML = '';
    //
    //     jobs.forEach(job => {
    //         const jobItem = createJobItem(job);
    //         jobList.appendChild(jobItem);
    //     });
    // } catch (error) {
    //     console.error('Error loading jobs:', error);
    // }
}

// Create job item element (helper function)
function createJobItem(job) {
    const li = document.createElement('li');
    li.innerHTML = `
        <strong>• ${job.title}</strong><br>
        <span class="job-details">${job.type} - ${job.location}</span>
    `;
    return li;
}

// Initialize carousel with images from database (example function)
async function loadCarouselImages() {
    // This function can be used to load carousel images from your MySQL database
    // Example:
    // try {
    //     const response = await fetch('/api/projects');
    //     const projects = await response.json();
    //
    //     const carouselTrack = document.querySelector('.carousel-track');
    //     carouselTrack.innerHTML = '';
    //
    //     // Add images twice for continuous scroll effect
    //     for (let i = 0; i < 2; i++) {
    //         projects.forEach(project => {
    //             const slide = createCarouselSlide(project);
    //             carouselTrack.appendChild(slide);
    //         });
    //     }
    // } catch (error) {
    //     console.error('Error loading carousel images:', error);
    // }
}

// Create carousel slide element (helper function)
function createCarouselSlide(project) {
    const slide = document.createElement('div');
    slide.className = 'carousel-slide';
    slide.innerHTML = `<img src="${project.image}" alt="${project.title}">`;
    return slide;
}