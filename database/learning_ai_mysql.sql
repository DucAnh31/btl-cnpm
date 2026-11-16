CREATE DATABASE learning_ai
USE learning_ai;
CREATE TABLE users (
                       id BIGINT(20) NOT NULL AUTO_INCREMENT,
                       full_name VARCHAR(120) NOT NULL,
                       email VARCHAR(254) NOT NULL,
                       password_hash VARCHAR(255) NOT NULL,
                       role ENUM('ADMIN', 'TEACHER', 'STUDENT') NOT NULL DEFAULT 'STUDENT',
                       is_active TINYINT(1) NOT NULL DEFAULT 1,
                       PRIMARY KEY (id),
                       CONSTRAINT uq_users_email UNIQUE (email)
)

CREATE TABLE categories (
                            id BIGINT(20) NOT NULL AUTO_INCREMENT,
                            name VARCHAR(120) NOT NULL,
                            description TEXT NULL,
                            PRIMARY KEY (id),
                            CONSTRAINT uq_categories_name UNIQUE (name)
)

CREATE TABLE courses (
                         id BIGINT(20) NOT NULL AUTO_INCREMENT,
                         title VARCHAR(200) NOT NULL,
                         description TEXT NULL,
                         thumbnail_url VARCHAR(2048) NULL,
                         thumbnail_storage_key VARCHAR(512) NULL,
                         price DECIMAL(14, 2) NOT NULL DEFAULT 0.00,
                         is_published TINYINT(1) NOT NULL DEFAULT 0,
                         archived_at DATETIME(6) NULL,
                         teacher_id BIGINT(20) NOT NULL,
                         category_id BIGINT(20) NOT NULL,
                         PRIMARY KEY (id),
                         CONSTRAINT fk_courses_teacher FOREIGN KEY (teacher_id) REFERENCES users (id) ON DELETE RESTRICT,
                         CONSTRAINT fk_courses_category FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE RESTRICT
)

CREATE TABLE lessons (
                         id BIGINT(20) NOT NULL AUTO_INCREMENT,
                         title VARCHAR(200) NOT NULL,
                         video_url VARCHAR(2048) NOT NULL,
                         transcript_text TEXT NULL,
                         order_index INT(11) NOT NULL,
                         course_id BIGINT(20) NOT NULL,
                         PRIMARY KEY (id),
                         CONSTRAINT fk_lessons_course FOREIGN KEY (course_id) REFERENCES courses (id) ON DELETE CASCADE,
                         CONSTRAINT uq_lessons_course_order UNIQUE (course_id, order_index)
)

CREATE TABLE lesson_documents (
                                  id BIGINT(20) NOT NULL AUTO_INCREMENT,
                                  title VARCHAR(200) NOT NULL,
                                  file_name VARCHAR(255) NOT NULL,
                                  file_type ENUM('PDF', 'TXT') NOT NULL,
                                  file_path VARCHAR(2048) NOT NULL,
                                  extracted_text TEXT NULL,
                                  order_index INT(11) NOT NULL DEFAULT 1,
                                  lesson_id BIGINT(20) NOT NULL,
                                  PRIMARY KEY (id),
                                  CONSTRAINT fk_lesson_documents_lesson FOREIGN KEY (lesson_id) REFERENCES lessons (id) ON DELETE CASCADE
)

CREATE TABLE course_members (
                                id BIGINT(20) NOT NULL AUTO_INCREMENT,
                                enrolled_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
                                student_id BIGINT(20) NOT NULL,
                                course_id BIGINT(20) NOT NULL,
                                PRIMARY KEY (id),
                                CONSTRAINT fk_course_members_student FOREIGN KEY (student_id) REFERENCES users (id) ON DELETE CASCADE,
                                CONSTRAINT fk_course_members_course FOREIGN KEY (course_id) REFERENCES courses (id) ON DELETE CASCADE,
                                CONSTRAINT uq_course_members_course_student UNIQUE (course_id, student_id)
)