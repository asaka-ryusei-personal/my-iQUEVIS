import { Form } from "react-bootstrap";
import styles from "./DescriptionInputForm.module.css";

export type DescriptionInputFormProps = {
  questionId: number;
  questionTitle: string;
  isRequired: boolean;
  description?: string;
};

export default function DescriptionInputForm({
  questionId,
  questionTitle,
  isRequired,
  description,
}: DescriptionInputFormProps) {
  return (
    <Form.Group>
      <Form.Label className={styles.questionTitle}>
        {questionId}. {questionTitle} <span className={styles.isRequired}>{isRequired ? "*" : ""}</span>
      </Form.Label>
      <br />
      <Form.Text className="text-muted">{description}</Form.Text>
      <Form.Control type="text" placeholder="ここに入力してください。" />
    </Form.Group>
  );
}
