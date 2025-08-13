"use client";

import NormalButton from "@/components/NormalButton/NormalButton";
import InputLoginPassword from "@/components/InputLoginPassword/InputLoginPassword";
import { Col, Container, FloatingLabel, Form, Row } from "react-bootstrap";
import styles from "./page.module.css";

export default function page() {
  return (
    <>
      <Container
        className="d-flex flex-column justify-content-center align-items-center"
        style={{ height: "100vh" }}
      >
        {/* ロゴ */}
        <Row className="justify-content-center mb-4">
          <Col md="auto">
            <div className={styles.loginLogo}>
              <span className={styles.italic}>i</span>QUEVIS
            </div>
          </Col>
        </Row>

        <Form>
          {/* esq-id */}
          <Row className="justify-content-center mb-1">
            <Col md="auto" className={styles.inputForm}>
              <FloatingLabel controlId="esqId" label="ESQ-ID">
                <Form.Control
                  type="text"
                  placeholder="ESQ-ID"
                  className={styles.inputShadow}
                />
              </FloatingLabel>
            </Col>
          </Row>
          {/* password */}
          <Row className="justify-content-center mb-3">
            <Col md="auto" className={styles.inputForm}>
              <InputLoginPassword/>
            </Col>
          </Row>

          {/* ログインボタン */}
          <Row className="justify-content-center">
            <Col md="auto">
              <NormalButton
                type="submit"
                label="Login"
                href="/login"
                isDisabled={false}
              />
            </Col>
          </Row>
        </Form>
      </Container>
    </>
  );
}
