import { Form } from "react-bootstrap";
import styles from "./ToggleButton.module.css";

export type ToggleButtonProps = {
  label: string;
  checked: boolean;
  onChange: (checked: boolean) => void;
};

const ToggleButton: React.FC<ToggleButtonProps> = ({
  label,
  checked,
  onChange,
}) => {
  return (
    <Form.Check
      type="switch"
      id="custom-switch"
      label={label}
      className={styles.toggleButton}
      checked={checked}
      onChange={(e) => onChange(e.target.checked)}
    />
  );
};

export default ToggleButton;