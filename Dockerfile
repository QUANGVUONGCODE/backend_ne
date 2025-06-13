FROM maven:3.9.9-eclipse-temurin-21 AS build

# Sao chép file pom.xml và các file cần thiết để xây dựng ứng dụng
COPY . .
RUN mvn clean package -DskipTests




# Sử dụng image OpenJDK 17 (phù hợp với Spring Boot)
FROM eclipse-temurin:21.0.7_6-jdk

# Tạo thư mục làm việc trong container
WORKDIR /app

# Sao chép file JAR từ thư mục gym/gym/target

COPY --from=build /app/target/gym-0.0.1-SNAPSHOT.jar app.jar



# Cổng mặc định của Spring Boot
EXPOSE 8080

# Lệnh khởi động ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]
