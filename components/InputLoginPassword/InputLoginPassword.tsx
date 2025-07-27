import React, { useState } from "react";
import { FloatingLabel, Form, InputGroup } from "react-bootstrap";
import { FaEye, FaEyeSlash } from "react-icons/fa";
import styles from "./InputLoginPassword.module.css";
import pageStyles from "../../app/login/page.module.css";

export default function InputLoginPassword() {
  const [showPassword, setShowPassword] = useState(false);

  return (
    <InputGroup className={pageStyles.inputShadow}>
      <FloatingLabel controlId="password" label="Password">
        <Form.Control
          type={showPassword ? "text" : "password"}
          placeholder="Password"
        />
      </FloatingLabel>
      <InputGroup.Text onClick={() => setShowPassword(!showPassword)}>
        {showPassword ? <FaEyeSlash /> : <FaEye />}
      </InputGroup.Text>
    </InputGroup>
  );
}
