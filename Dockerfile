# ใช้ Node.js image
FROM node:16

# ตั้ง working directory
WORKDIR /app

# คัดลอก package.json และ package-lock.json (ถ้ามี) เข้าไปใน container
COPY package*.json ./

# ลบ node_modules และ package-lock.json ถ้ามีอยู่
RUN rm -rf node_modules package-lock.json

# ติดตั้ง dependencies ใหม่
RUN npm install

# คัดลอกไฟล์โปรเจกต์ทั้งหมดเข้าไปใน container
COPY . .

# เปิดพอร์ต 5000 สำหรับการเข้าถึงจากภายนอก
EXPOSE 5000

# รันคำสั่ง `npm run dev --host` เพื่อเริ่มเซิร์ฟเวอร์ Svelte
CMD ["npm", "run", "dev"]
