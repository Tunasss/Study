document.addEventListener('DOMContentLoaded', () => {
    const nav = document.querySelector('nav');
    
    // Scroll effect for navbar
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            nav.classList.add('scrolled');
        } else {
            nav.classList.remove('scrolled');
        }
    });

    // Form Handling (if on contact page)
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', (e) => {
            e.preventDefault();
            
            // Get form data
            const formData = new FormData(contactForm);
            const name = formData.get('name');
            const email = formData.get('email');
            
            // Animation for submit button
            const submitBtn = contactForm.querySelector('button');
            const originalText = submitBtn.innerText;
            submitBtn.innerText = 'Đang gửi...';
            submitBtn.disabled = true;

            setTimeout(() => {
                alert(`Cảm ơn ${name}! Chúng tôi đã nhận được tin nhắn và sẽ liên hệ lại với bạn qua email ${email} sớm nhất.`);
                submitBtn.innerText = originalText;
                submitBtn.disabled = false;
                contactForm.reset();
            }, 1500);
        });
    }

    // Scroll reveal animation (simple)
    const observerOptions = {
        threshold: 0.1
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    document.querySelectorAll('.card, .about-content').forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'all 0.6s ease-out';
        observer.observe(el);
    });
});
