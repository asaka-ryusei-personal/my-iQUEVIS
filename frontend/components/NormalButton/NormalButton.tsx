import { Button } from "react-bootstrap";
import styles from "./NormalButton.module.css";

type NormalButtonProps = {
  type?: "button" | "submit" | undefined;
  label: string;
  href: string;
  isDisabled?: boolean;
  onClick?: () => void;
};

export default function NormalButton({
  label,
  href,
  isDisabled = false,
  onClick,
}: NormalButtonProps) {
  return (
    <>
      <Button
        variant="primary"
        disabled={isDisabled}
        href={href}
        onClick={onClick}
      >
        {label}
      </Button>
    </>
  );
}
