document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('onboardingForm');
  const photoInput = document.getElementById('photoInput');
  const photoPreview = document.getElementById('photoPreview');
  const success = document.getElementById('success');

  photoInput.addEventListener('change', (e) => {
    const file = e.target.files && e.target.files[0];
    if (!file) {
      photoPreview.innerHTML = 'Preview';
      return;
    }
    const reader = new FileReader();
    reader.onload = () => {
      const img = document.createElement('img');
      img.src = reader.result;
      img.alt = 'Profile photo';
      img.className = 'object-cover w-full h-full';
      photoPreview.innerHTML = '';
      photoPreview.appendChild(img);
    };
    reader.readAsDataURL(file);
  });

  form.addEventListener('submit', (e) => {
    e.preventDefault();
    // Basic required validation is handled by HTML `required` attributes.
    // Collect form data and show demo success message.
    const data = new FormData(form);
    const obj = {};
    for (const [k, v] of data.entries()) {
      if (obj[k]) {
        if (Array.isArray(obj[k])) obj[k].push(v);
        else obj[k] = [obj[k], v];
      } else obj[k] = v;
    }
    console.log('Onboarding form submitted (demo):', obj);
    success.classList.remove('hidden');
    success.scrollIntoView({behavior: 'smooth'});
  });
});