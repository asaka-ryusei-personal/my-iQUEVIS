import React from 'react';
import { Navbar, Container } from 'react-bootstrap';
import styles from './Header.module.css';

const Header: React.FC = () => {
  return (
    <>
      <Navbar style={{ position: 'relative' }} className="p-3" bg="transparent">
        <Container className="d-flex justify-content-between align-items-center">
          {/* 左側のヘッダータイトル */}
          <Navbar.Brand style={{ fontSize: '1.5rem', fontWeight: 'bold' }}>
            i<span className={styles.italicI}>QUEVIS</span>
          </Navbar.Brand>

          {/* 右側のユーザー情報と楕円 */}
          <div style={{ position: 'relative' }}>
            <div className={styles.ellipse}></div>
            <span className={styles.welcome}>ようこそ li4646 剛田武 さん</span>
          </div>
        </Container>
      </Navbar>

      {/* 左下の楕円 */}
      <div className={styles.leftEllipse}></div>
    </>
  );
};

export default Header;
