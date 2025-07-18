"use client";

import { Button, Container, Nav, Navbar } from "react-bootstrap";
import styles from "./Header.module.css";

export default function Header() {
  return (
    <Navbar
      expand="lg"
      fixed="top"
      className={`${styles.navbar} bg-transparent`}
    >
      <Container fluid className={styles.container}>
        <Navbar.Brand href="/" className={styles.brand}>
          <span className={styles.italicI}>i</span>QUEVIS
        </Navbar.Brand>
        <Nav className={styles.rightSection}>
          <Navbar.Text className={styles.welcome}>
            ようこそ <strong>li0000 剛田武</strong> さん
          </Navbar.Text>
          <Button
            variant="outline-light"
            size="sm"
            className={styles.logoutButton}
          >
            ログアウト
          </Button>
        </Nav>
      </Container>
    </Navbar>
  );
}
